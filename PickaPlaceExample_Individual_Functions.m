%THIS example utilizes the individual functions to develop a pick and place
%task, with the placement of three connectors on a PCB board; 
%When the board is full we press a button connected to DI 7 to restart
%the process;

addpath(genpath('Individual function Library'));
%% Connection
ip="192.168.0.111";
socketport=5890;
modbusport=502;
[client,m]=connect2controller(ip,socketport,modbusport); %establish connection
%% Poses
home_pos    = [220.004 -200.002 350.004 180 -0.001 141.999];
component   = [160.501 -411.200 252.001 179.990 0.005 141.448];
pcb         = [454.298 135.495 224.457 179.891 0.04 139.8];
%% Movement
closegripper(m,client);
while(1)
    for i=0:2
            
        LineMove2pos(client,home_pos,100);   % initial position ; move with 100% velocity
        disp('Home Position Reached');
        
        LineMove2pos(client,[(component(1)+i*0.613) (component(2)+i*55.468) component(3) component(4) component(5) component(6)],100);  % 1st component position ; move with 100% velocity
        disp('Ready to pick component');
        MoveZ(client,m,-30,"Line",50);                      % movement in Z axis to pick the component ; 50% velocity
        disp('Grabbing component...')
        opengripper(m,client);                              % open gripper to grab component
        
        MoveZ(client,m,50,"Line",50);                       % movement in Z axis to get away from the board ; 50% velocity
        disp('Component acquired');
        LineMove2pos(client,home_pos,100);   
        disp('Moving component to PCB place position');
        LineMove2pos(client,[(pcb(1)-i*51.5) (pcb(2)+i*0.752) pcb(3) pcb(4) pcb(5) pcb(6)] ,100);        % 1st position to place component in PCB; move with 100% velocity
        disp('Ready for placement');
        MoveZ(client,m,-30,"Line",10);                      % movement in Z axis to get close to PCB ; 50% velocity
        
        closegripper(m,client);                             % close gripper to release component
        disp('Component inserted')
        MoveZ(client,m,30,"Line",50);                       % movement in Z axis to get away from the PCB ; 50% velocity
    end

    LineMove2pos(client,home_pos,100);

    while(getDI(m,7)==0) %waiting for button pressed;
    end
end   