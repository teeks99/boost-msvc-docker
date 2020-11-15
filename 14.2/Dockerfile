#escape=`
FROM teeks99/boost-msvc:14.2
  
# Install Chocolatey
RUN powershell -Command `
    iex ((new-object net.webclient).DownloadString('https://chocolatey.org/install.ps1')); `
    choco feature disable --name showDownloadProgress; `
	choco feature enable --name allowGlobalConfirmation
	
COPY Packages.config Packages.config
RUN powershell -Command `
    choco install Packages.config

# Define the entry point for the docker container.
# This entry point adds the developer environemnt and starts the command shell
ENTRYPOINT ["C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\BuildTools\\Common7\\Tools\\VsDevCmd.bat", `
    "&&", "cmd.exe"]

