# Imagem base
FROM alpine:3.14

# Instalação de pacotes PHP e Apache
RUN apk add --no-cache \
    apache2 \
    apache2-utils \
    php7 \
    php7-apache2 \
    php7-mysqli \
    php7-json \
    php7-gd \
    php7-curl \
    php7-mbstring \
    php7-xml \
    php7-zip \
    php7-session \
    php7-mysqlnd

# Configuração do Apache
RUN sed -i 's/Listen 80/Listen 8080/g' /etc/apache2/httpd.conf
RUN sed -i 's/DirectoryIndex index.html/DirectoryIndex index.php index.html/g' /etc/apache2/httpd.conf
RUN sed -i 's/#LoadModule rewrite_module/LoadModule rewrite_module/g' /etc/apache2/httpd.conf
RUN sed -i 's/AllowOverride None/AllowOverride All/g' /etc/apache2/httpd.conf
RUN sed -i 's/User apache/User apache/g' /etc/apache2/httpd.conf
RUN sed -i 's/Group apache/Group apache/g' /etc/apache2/httpd.conf

# Habilitar mod_rewrite e definir o servidor como não-daemon
RUN echo "LoadModule rewrite_module modules/mod_rewrite.so" > /etc/apache2/conf.d/rewrite.conf
RUN echo "ServerName localhost" >> /etc/apache2/httpd.conf
RUN echo "PidFile /run/apache2/httpd.pid" >> /etc/apache2/httpd.conf

# Expor a porta 8080 para o tráfego HTTP
EXPOSE 8080

# Diretório de trabalho do Apache
WORKDIR /var/www/localhost/htdocs

# Copiar os arquivos do WordPress (você pode adaptar esta parte conforme necessário)
COPY ./projeto/ /var/www/localhost/htdocs/

# Define o comando de inicialização do container
CMD ["httpd", "-D", "FOREGROUND"]
