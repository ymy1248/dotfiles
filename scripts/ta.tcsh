tmux has -t "$1"                             
if ($? == 1) then                            
    echo "No $1 session. Create new one? [n]"
    set remove = "$<"                        
    if ($remove == 'y') then                 
        tmux new-session -d -s "$1"          
        tmux rename-window -t "$1":1 code    
        tmux new-window -t "$1":2 -n Rg      
    else                                     
        exit 0                               
    endif                                    
endif                                        
tmux attach -dt $1                           
