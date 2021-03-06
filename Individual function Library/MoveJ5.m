%Moves Joint 5 valueº from actual joint5  
%Inputs: cliente= TCP/IP Client Object;
%        m= Modbus Object;
%        value in degrees;
%        velperc= movement velocity in %, robo will take 100 ms to get to
%        full speed;
%Output: check=Reachable pose or not reachable pose;
%        move= Movement completed or not completed;

function [check,move]=MoveJ5(client,m,value,velperc)

    
    currentjointpose=getRealjoints(m);

    currentjointpose(5)=currentjointpose(5)+value;

    [check,move]=Move2joint(client,currentjointpose,velperc);
end

