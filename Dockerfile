FROM mcr.microsoft.com/dotnet/sdk:10.0 AS build
WORKDIR /src

COPY SemanticWeb/SemanticWeb.csproj SemanticWeb/
RUN dotnet restore SemanticWeb/SemanticWeb.csproj

COPY . .
RUN dotnet publish SemanticWeb/SemanticWeb.csproj -c Release -o /app/publish --no-restore

FROM mcr.microsoft.com/dotnet/aspnet:10.0 AS final
WORKDIR /app
COPY --from=build /app/publish .

# Render injects the PORT environment variable at runtime; the app listens on it (see Program.cs).
EXPOSE 8080
ENTRYPOINT ["dotnet", "SemanticWeb.dll"]
