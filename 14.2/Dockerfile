#escape=`
FROM teeks99/msvc-win:14.2
  
# Install Chocolatey
RUN powershell -Command `
    iex ((new-object net.webclient).DownloadString('https://chocolatey.org/install.ps1')); `
    choco feature disable --name showDownloadProgress; `
	choco feature enable --name allowGlobalConfirmation

COPY Packages.config Packages.config
COPY user-config.jam user-config.jam
RUN powershell -Command `
    choco install Packages.config; `
    setx /M PYTHONIOENCODING UTF-8; `
    del .\Packages.config; `
    move .\user-config.jam $env:USERPROFILE; 

# Add root certificates to the container
RUN powershell -Command "`
    cd $env:USERPROFILE; `
    Invoke-WebRequest https://curl.haxx.se/ca/cacert.pem -OutFile $env:USERPROFILE\cacert.pem; `
    $plaintext_pw = 'PASSWORD'; `
    $secure_pw = ConvertTo-SecureString $plaintext_pw -AsPlainText -Force; `
    & 'C:\Program Files\OpenSSL-Win64\bin\openssl.exe' pkcs12 -export -nokeys -out certs.pfx -in cacert.pem -passout pass:$plaintext_pw; `
    Import-PfxCertificate -Password $secure_pw  -CertStoreLocation Cert:\LocalMachine\Root -FilePath certs.pfx; `
    "ca_certificate = $env:USERPROFILE\cacert.pem" > .wgetrc; `
    setx /M HOME $env:USERPROFILE; "

# Define the entry point for the docker container.
# This entry point adds the developer environemnt and starts the command shell
ENTRYPOINT ["C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\BuildTools\\Common7\\Tools\\VsDevCmd.bat", `
    "&&", "cmd.exe"]

