FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build-env
LABEL stage=build-env
WORKDIR /app

# Copy and build
COPY ./src /app
RUN dotnet publish /app/OrchardCore.Cms.Web -c Release -o ./build/release --framework net8.0

# Build runtime image
FROM mcr.microsoft.com/dotnet/aspnet:8.0
EXPOSE 80
ENV ASPNETCORE_URLS http://+:80
WORKDIR /app
COPY --from=build-env /app/build/release .
ENTRYPOINT ["dotnet", "OrchardCore.Cms.Web.dll"]
