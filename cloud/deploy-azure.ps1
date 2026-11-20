# Exercise 5 - Deploy to Microsoft Azure (Azure CLI). Replace the values below.
$RG="se-lab10-rg"; $ACR="selab10registry"; $APP="selab10-webapp"; $LOC="southeastasia"
az login
az group create --name $RG --location $LOC
az acr create --resource-group $RG --name $ACR --sku Basic --admin-enabled true
az acr login --name $ACR
docker tag myaspnetcoreapp "$ACR.azurecr.io/myaspnetcoreapp:latest"
docker push "$ACR.azurecr.io/myaspnetcoreapp:latest"
az appservice plan create --name "$APP-plan" --resource-group $RG --is-linux --sku B1
az webapp create --resource-group $RG --plan "$APP-plan" --name $APP --deployment-container-image-name "$ACR.azurecr.io/myaspnetcoreapp:latest"
az webapp config appsettings set --resource-group $RG --name $APP --settings WEBSITES_PORT=80
Write-Host "Open https://$APP.azurewebsites.net"
