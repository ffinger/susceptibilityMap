function [t,y]=solveEqs2(dCdt,par,nnodes,tspan,y0)

    % I(timestep,node) = y(timestep,1:2:end)
    % R_sympt(timestep,node) = y(timestep,2:2:end)
    % R_asympt(timestep,node) = y(timestep,3:2:end)

    [t,y]=ode45(@eqs,tspan,y0);

    function dy=eqs(t,y)
        index_t=floor(t-tspan(1))+1;
        neqs=3;
        dy=zeros(neqs*nnodes,1);
        dy(1:neqs:end) = dCdt(:,index_t) - (par.gamma+par.mu+par.alpha)*y(1:neqs:end);
        dy(2:neqs:end) = -(par.rhoS+par.mu)*y(2:neqs:end) + par.gamma*y(1:neqs:end);
        dy(3:neqs:end) = -(par.rhoA+par.mu)*y(3:neqs:end) + ((1-par.sigma)/par.sigma)*dCdt(:,index_t);
    end
end