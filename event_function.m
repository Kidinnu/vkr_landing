function [value,isterminal,direction] = event_function(t,q,p,c)
    value      = q(1)-p.Rz;
    isterminal = 1;
    direction  = -1;
end

