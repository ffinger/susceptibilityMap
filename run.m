clear all;
close all;
addpath utilities;

%% load case data

load data/casedata_new_Sept2016
caseData=cases_with_PaP; %has to be nnodes x ndates
datesCases=date_cases; %has to be ndates x 1
[ndates,~]=size(datesCases);
[nnodes,~]=size(caseData);
names={'ARTIBONITE','CENTRE','GRANDE ANSE','NIPPES','Nord','Nord Est','Nord Ouest','OUEST','PaP','Sud','Sud Est'};

%% load population
H=xlsread('data/pop_dept.xls',1);
H=H(1:11,2);
HH=repmat(H',ndates,1);

%% set parameters

parameters=struct();

%fixed:
parameters.mu=1/(61.4*365);
parameters.gamma=0.2;
parameters.alpha=-log(0.98)*parameters.gamma;

%% first scenario: ignore asymptomatics

parameters.sigma=1;
imdur=[0.5,1:5];
rho=1./(365*imdur);

fig=figure();
fig.PaperUnits = 'centimeters';
fig.Units = 'centimeters';
fig.Position = [0 0 50 4];
fig.PaperPosition = [0 0 50 4];

cscale=[.7,1];

for i=1:length(rho)
    
    %parameters to vary:
    parameters.rho=rho(i); %units: 1/days

    % initial conditions
    %at the beginning of the epidemic, in 2010
    I0=zeros(1,nnodes);
    R0=zeros(1,nnodes);
    y0=[I0;R0];

    % solve
    % I(timestep,node) = y(timestep,1:2:end)
    % R(timestep,node) = y(timestep,2:2:end)

    dCdt=caseData;
    tspan=datesCases;
    [t,y]=solveEqs1(dCdt,parameters,nnodes,tspan,y0);
    I = y(:,1:2:end);
    R = y(:,2:2:end);
    S = HH-R-I;

    % plot

    h=subaxis(1,length(rho),i,'Spacing',0,'Padding',0,'Margin',0,'MarginTop',0.02,'MarginLeft',0.02,'MarginRight',0.05);
    
    plotAreasShape(S(end,:)./H',names,'dept+pap',cscale,false,h)
    text(0.5,0.88,num2str(imdur(i)),'Units','normalized')        
end

ax=subplot('position',[0.95,0.1,0.03,0.8],'visible','off');
caxis(cscale)
colormap(viridis)
colorbar(ax,'location','east')

ax=axes('position',[0,0,1,1],'visible','off');
text(0.4,0.95,'mean immunity duration','Units','normalized')

% save

print -dpng result/result_scenario1.png


%% second scenario: symptomatics and asymptomatics have the same immunity duration

imdur=[0.5,1:5];
rho=1./(365*imdur);
sigma=[0.05,0.1,0.15,0.2];

fig=figure();
fig.PaperUnits = 'centimeters';
fig.Units = 'centimeters';
fig.Position = [0 0 50 30];
fig.PaperPosition = [0 0 50 30];

cscale=[0,1];

for i=1:length(rho)
    for j=1:length(sigma)

        %parameters to vary:
        parameters.rho=rho(i); %units: 1/days
        parameters.sigma=sigma(j);

        % initial conditions
        %at the beginning of the epidemic, in 2010
        I0=zeros(1,nnodes);
        R0=zeros(1,nnodes);
        y0=[I0;R0];

        % solve
        % I(timestep,node) = y(timestep,1:2:end)
        % R(timestep,node) = y(timestep,2:2:end)

        dCdt=caseData;
        tspan=datesCases;
        [t,y]=solveEqs1(dCdt,parameters,nnodes,tspan,y0);
        I = y(:,1:2:end);
        R = y(:,2:2:end);
        S = HH-R-I;

        % plot

        h=subaxis(length(sigma),length(rho),i+(j-1)*length(rho),'Spacing',0,'Padding',0,'Margin',0,'MarginTop',0.02,'MarginLeft',0.02,'MarginRight',0.05);
        plotAreasShape(S(end,:)./H',names,'dept+pap',cscale,false,h)
        if j==1
            text(0.5,1.0,num2str(imdur(i)),'Units','normalized')
        end
        if i==1
            text(0,0.5,num2str(sigma(j)),'Units','normalized')
        end
        
    end
end

ax=subplot('position',[0.95,0.1,0.03,0.8],'visible','off');
caxis(cscale)
colormap(viridis)
colorbar(ax,'location','east')

ax=axes('position',[0,0,1,1],'visible','off');
text(0.01,0.4,'proportion of symptomatics','Units','normalized','Rotation',90)
text(0.4,0.99,'mean immunity duration (symptomatics and asymptomatics)','Units','normalized')

% save

print -dpng result/result_scenario2.png


%% third scenario: asymptomatics have a different immunity duration

parameters.rhoS=1/(4*365); %symptomatics immunity duration
imdur=[0.5,1:5];
rhoA=1./(365*imdur);
sigma=[0.05,0.1,0.15,0.2];

fig=figure();
fig.PaperUnits = 'centimeters';
fig.Units = 'centimeters';
fig.Position = [0 0 50 30];
fig.PaperPosition = [0 0 50 30];

cscale=[0,1];

for i=1:length(rho)
    for j=1:length(sigma)

        %parameters to vary:
        parameters.rhoA=rho(i); %units: 1/days
        parameters.sigma=sigma(j);

        % initial conditions
        %at the beginning of the epidemic, in 2010
        I0=zeros(1,nnodes);
        R0_S=zeros(1,nnodes);
        R0_A=zeros(1,nnodes);
        y0=[I0;R0_S;R0_A];

        % solve
        % I(timestep,node) = y(timestep,1:3:end)
        % R_S(timestep,node) = y(timestep,2:3:end)
        % R_A(timestep,node) = y(timestep,3:3:end)

        dCdt=caseData;
        tspan=datesCases;
        [t,y]=solveEqs2(dCdt,parameters,nnodes,tspan,y0);
        I = y(:,1:3:end);
        R_S = y(:,2:3:end);
        R_A = y(:,3:3:end);
        S = HH-R_S-R_A-I;

        % plot

        h=subaxis(length(sigma),length(rho),i+(j-1)*length(rho),'Spacing',0,'Padding',0,'Margin',0,'MarginTop',0.02,'MarginLeft',0.02,'MarginRight',0.05);
        plotAreasShape(S(end,:)./H',names,'dept+pap',cscale,false,h)
        if j==1
            text(0.5,1.0,num2str(imdur(i)),'Units','normalized')
        end
        if i==1
            text(0,0.5,num2str(sigma(j)),'Units','normalized')
        end
        
    end
end

ax=subplot('position',[0.95,0.1,0.03,0.8],'visible','off');
caxis(cscale)
colormap(viridis)
colorbar(ax,'location','east')

ax=axes('position',[0,0,1,1],'visible','off');
text(0.01,0.4,'proportion of symptomatics','Units','normalized','Rotation',90)
text(0.4,0.99,'mean immunity duration (asymptomatics)','Units','normalized')

% save

print -dpng result/result_scenario3.png
