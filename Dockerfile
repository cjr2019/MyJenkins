#See https://aka.ms/containerfastmode to understand how Visual Studio uses this Dockerfile to build your images for faster debugging.

#FROM microsoft/aspnetcore:2.0-stretch AS base
FROM docker.io/microsoft/dotnet:latest 
WORKDIR /app
EXPOSE 80

#FROM microsoft/aspnetcore-build:2.0-stretch AS build
FROM docker.io/microsoft/dotnet:latest
WORKDIR /src
COPY ["MyJenkins.csproj", "./"]
RUN dotnet restore "MyJenkins.csproj"
COPY . .
WORKDIR "/src/"
RUN dotnet build "MyJenkins.csproj" -c Release -o /app/build

#FROM build AS publish
RUN dotnet publish "MyJenkins.csproj" -c Release -o /app/publish

#FROM base AS final
WORKDIR /app
#COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "MyJenkins.dll"]
