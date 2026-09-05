FROM mcr.microsoft.com/dotnet/sdk:10.0 AS build
WORKDIR /src

COPY SemanticWeb/SemanticWeb.csproj SemanticWeb/
# Warms the NuGet cache so the publish below restores from disk instead of the network.
RUN dotnet restore SemanticWeb/SemanticWeb.csproj

COPY . .
# Do NOT add --no-restore here: a restore that ran before the sources were copied
# leaves the framework static web assets (wwwroot/_framework/blazor.web.js) out of
# the publish output, which silently breaks all Blazor interactivity at runtime.
RUN dotnet publish SemanticWeb/SemanticWeb.csproj -c Release -o /app/publish

# Fail the build rather than shipping a page whose components never become interactive.
RUN test -f /app/publish/wwwroot/_framework/blazor.web.js \
    || (echo "ERROR: blazor.web.js missing from publish output" && exit 1)

FROM mcr.microsoft.com/dotnet/aspnet:10.0 AS final
WORKDIR /app
COPY --from=build /app/publish .

# Render injects the PORT environment variable at runtime; the app listens on it (see Program.cs).
EXPOSE 8080
ENTRYPOINT ["dotnet", "SemanticWeb.dll"]
