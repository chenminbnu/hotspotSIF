function RMSE = calculateRMSE(obs, sim)
filters = ~isnan(obs) & ~isnan(sim);
if(sum(filters)<1)
    RMSE = nan;
else
   RMSE = sqrt(mean((obs-sim).^2));
end