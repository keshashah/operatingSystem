% ------------------------------------------------------------------%
% PAGING simulation program
%
%
% nested loop structure:
% outer loop -- varies locality parameter from 0 to 0.9
% inner loop -- varies number of physical pages from 1 to nlogical 
%
% main program calls:
% function generate_page_ref to generate page reference requence
%   (called from outer loop)
%
% function page_faults to count number of page faults
%   (called from inner loop)
%
function PAGING()
%
global page_ref             % page reference sequence  
rcnt = 2000;                % number of page references simulated
page_ref = zeros(1,rcnt);   % array to hold the page reference 
                            % sequence
%
nlogical = 20;              % number of logical pages
nlocal = 6;                 % page range of program locality 
%
locality = [0:9]*0.1;       % ten values of locality parameter
%                           % = probability of making local reference
%
result = zeros(1,nlogical); % number of physical pages is varied 
%                           % from 1 to nlogical (in inner loop)
%
colors = 'bgrmkbgrmk';      % choice of colors for the plot
%
for j = 1 : 10
    % outer loop -- locality parameter: 0 to 0.9 (see above)
    %
    % generate page reference string with given locality parameter
    generate_page_ref(nlogical, nlocal, locality(j));
    %
    for nphysical = 1 : nlogical
        % inner loop -- physical pages from 1 to nlogical
        %
        % calculate number of page faults
        result(nphysical) = page_faults( nphysical );
    end;
    %
    linestyle = colors(j);                  % first five lines solid
    if j > 5 
        linestyle = [ colors(j) '--' ];     %  next five lines dashed
    end;
    plot([1:nlogical], result, linestyle,'LineWidth',2);
    hold on;
    %
end
%
% some decoration for the plot!
%
legend('loc: 0.0', 'loc: 0.1', 'loc: 0.2', 'loc: 0.3', 'loc: 0.4', ...
       'loc: 0.5', 'loc: 0.6', 'loc: 0.7', 'loc: 0.8', 'loc: 0.9' );
xlabel('NUMBER OF PHYSICAL PAGES');
ylabel('NUMBER OF PAGE FAULTS');
title ('PAGE FAULT ANALYSIS','fontsize',12);
%
end
%
% ------------------------------------------------------------------%
%
% Function to generate page references with given parameters
%
function generate_page_ref( nlogical, nlocal, locality )
%
% nlogical - number of logical pages
% nlocal   - page range of program locality 
% locality - locality parameter (= probablility of making local reference)
%            (note: main program uses an array of 10 locality values)
%
global page_ref                         % page reference string to generate
%
tmp = size(page_ref);
ref_cnt = tmp(2);
%
% create the first nlocal references
page_ref(1:nlocal) = floor(rand(1,nlocal)*nlogical);
%
% now create the remaining references 
%
% each reference generated is either local or general:
%   local -- uniformly distributed over the last nlocal references
%   general -- uniformly distributed over all nlogical pages
%
% probability of generating local reference = locality 
%
for k = nlocal+1 : ref_cnt
    local = rand() > 1-locality;                % boooean flag for local reference   
    if local
        back_ref = floor(rand()*nlocal);        % within the last nlocal references
        page_ref(k) = page_ref(k-back_ref);     %   > that is, local reference
    else
        page_ref(k) = floor(rand()*nlogical);   % general reference, that is >
                                                % anywhere in logical address space
    end
end
end
%
% ------------------------------------------------------------------%
%
% Function to simulate page faults in virtual memory
% LRU algorithn is applied 
%
function npf = page_faults( nphysical )
%
% nphysical - number of physical pages
%
npf = 0;            % number of page faults
%
global page_ref     % page reference sequence 
%
tmp = size(page_ref);
ref_cnt = tmp(2);
%
inmem = zeros(1,nphysical)-1;   % initialize to -1
%
for ref = 1 : ref_cnt
    %
    % check if referred page is in memory
    %
    found = find( inmem==page_ref(ref), 1 );
    %
    if isempty(found)
        %
        % referred page not in memory > page fault
        % - remove LRU page and add referred page
        % - note: LRU page is at index 1 (tail of list)
        %
        inmem = [ inmem(2:nphysical) page_ref(ref) ];
        npf = npf + 1;
    end;
end;
end
% ------------------------------------------------------------------%
%
%