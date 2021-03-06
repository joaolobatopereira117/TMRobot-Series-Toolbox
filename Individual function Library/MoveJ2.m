%Moves Joint 2 valueº from actual joint2  
%Inputs: cliente= TCP/IP Client Object;
%        m= Modbus Object;
%        value in degrees;
%        velperc= movement velocity in %, robo will take 100 ms to get to
%        full speed;
%Output: check=Reachable pose or not reachable pose;
%        move= Movement completed or not completed;

function [check,move]=MoveJ2(client,m,value,velperc)

    currentjointpose=getRealjoints(m);

    currentjointpose(2)=currentjointpose(2)+value;

    [check,move]=Move2joint(client,currentjointpose,velperc);
end

