function plotAreasShape(data,names,aggregation,cscale,cbar,ax,cmp)
 
    if nargin==3
        cscale=[min(data),max(data)];
    end
        
    if nargin<6
       ax=axes;
    end
    
    if nargin<5
        cbar=false;
    end
    
    if nargin<6
        cmp=viridis;
    end    

    shapefile='./shapefiles/Haiti_Communes_140_topology_corrected_3.shp';
    s=shaperead(shapefile);
    shapefDept='./shapefiles/Haiti_140_Departements.shp';
    sDept=shaperead(shapefDept);

    idx=zeros(size(s));
    
    if strcmp(aggregation,'dept')
        print 'aggregation not implemented!'
    elseif strcmp(aggregation,'dept+pap')
        communesPaP={'Carrefour', 'Cite Soleil','Delmas','Kenscoff','Petion-Ville','Port-au-Prince','Tabarre'};
        communesNonPaP={'Gressier','Leogane','Petit-Goave','Grand-Goave','Croix-des-Bouquets','Thomazeau','Ganthier','Cornillon / Grand-Bois','Fonds-Verrettes','Arcahaie','Cabaret','Anse-a-Galet','Pointe a Raquette'};
        for i=1:length(names)
            if ~strcmp(names(i),'PaP') && ~strcmp(names(i),'Ouest')
                idx(strcmp({s.DEPARTEMEN},names(i)))=i;
            elseif strcmp(names(i),'PaP')
                for j=1:length(communesPaP)
                    idx(strcmp({s.COMMUNE},communesPaP(j)))=i;
                end
            elseif strcmp(names(i),'Ouest')
                for j=1:length(communesNonPaP)
                    idx(strcmp({s.COMMUNE},communesNonPaP(j)))=i;
                end
            end
        end
        
        
    elseif strcmp(aggregation,'communes')
        print 'aggregation not implemented!'     
    end
    
    for i=1:length(s)
        s(i).data=data(idx(i));
    end
    
    densityColors = makesymbolspec('Polygon', {'data',cscale, 'FaceColor', cmp});

    mapshow(ax ,s, 'DisplayType', 'polygon','SymbolSpec', densityColors,'LineStyle','none')
    hold on
    mapshow(ax ,sDept, 'DisplayType', 'polygon','FaceColor','None')
    
    axis off
    
    if cbar
        caxis(cscale)
        colormap(cmp)
        colorbar
    end
    
        
   
end