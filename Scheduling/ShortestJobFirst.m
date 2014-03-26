%no of jobs
n = 5;
 
%assuming arrival time is in sorted order
arrival_time = [0;1;2;3;4];
processes = [1:1:n];
burst_time = [10;3;2;4;5];
turnaround = [ ];
waitingtime = [ ];
burst_time(n+1) = 999;
 
sum_bt = 0;
for i=1:1:n
  sum_bt = burst_time(i) + sum_bt;
end
sum_bt
time = 0;
sum_turnaround=0;
sum_wait = 0;
while time<sum_bt
  smallest = n+1;
  for i=1:1:n
    if arrival_time(i) <= time && burst_time(i) > 0 && burst_time(i)<burst_time(smallest)
      smallest = i;  
    end
  end
  turnaround(i) = time + burst_time(smallest)-arrival_time(smallest);
  waitingtime(i) = time - arrival_time(smallest);
  sum_turnaround = sum_turnaround + turnaround(i);
  sum_wait = sum_wait + waitingtime(i);
  time = time + burst_time(smallest);
  burst_time(smallest)=0;
end
 
avg_waiting = sum_wait * 1.0 /n
avg_turnaround = sum_turnaround* 1.0 /n
