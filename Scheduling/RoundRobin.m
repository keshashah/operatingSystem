
clear
disp('ROUND ROBIN ALGORITHM')
num_job = 5                             % No. of jobs
process_time = [5 8 2 1 4]              % Execution time of each job
process_time_copy = process_time;   
time_slot_interval = 2;                 %Length of one time slot 
totalprocess_time= sum(process_time)    %Total execution time of all the jobs
temp_time = totalprocess_time;
rnd_robin = [];                         
throughput = [];
wait = [];
colors = 'rgbkm'; 
resp_time = [];
z = 1;
 while (temp_time ~= 0)
     for i=1:1:num_job
        if process_time(i)>0
        if(z == 1)
            resp_time(i) = totalprocess_time - temp_time;
        end 
        
         if(process_time(i)>time_slot_interval)
             process_time(i) = process_time(i)- time_slot_interval;
             temp_time = temp_time- time_slot_interval;
         else 
            temp_time = temp_time - process_time(i);
            process_time(i) = 0;
            rnd_robin(i) = totalprocess_time-temp_time;
         
          end
        
    wait(i) = totalprocess_time - temp_time-process_time_copy(i);
        end
    end
    z = 0;
 end
rr_sum = sum(rnd_robin);
wait_sum = sum(wait);
rr_tput = rr_sum/num_job;
avg_wait_time = wait_sum/num_job;

%to display
wait
rr_tput
avg_wait_time
rnd_robin
resp_time
