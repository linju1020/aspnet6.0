 
#改造aspnet core官方镜像

FROM mcr.microsoft.com/dotnet/aspnet:6.0 AS runtime
WORKDIR /app

#修改openssl.cnf是能正常链接SQL Server数据库
RUN rm /etc/ssl/openssl.cnf
COPY ./openssl/openssl.cnf /etc/ssl/openssl.cnf

#切换apt-get到国内源 ,提高下载速度
RUN cp /etc/apt/sources.list /etc/apt/sources.list.bak
RUN rm /etc/apt/sources.list
COPY ./apt-get/sources.list /etc/apt/sources.list

# update apt
RUN apt-get update -y
# 安装Vim
#RUN apt-get install -y vim
# Mac 安装方式 brew install mono-libgdiplus
# 安装 绘图bitmap libgdiplus-devel  https://www.cnblogs.com/stulzq/p/10172550.html
RUN apt-get install -y libgdiplus && apt-get clean && ln -s /usr/lib/libgdiplus.so /usr/lib/gdiplus.dll
