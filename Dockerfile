# Use the official httpd:alpine base image
FROM httpd:alpine

# Install bash, curl, and necessary tools for mod_expires and mod_headers
RUN apk add --no-cache bash curl

# Enable CGI, mod_expires, and mod_headers manually (simulate 'a2enmod')
RUN echo "LoadModule cgi_module modules/mod_cgi.so" >> /usr/local/apache2/conf/httpd.conf && \
    echo "LoadModule headers_module modules/mod_headers.so" >> /usr/local/apache2/conf/httpd.conf && \
    echo "LoadModule expires_module modules/mod_expires.so" >> /usr/local/apache2/conf/httpd.conf

# Copy the script to the Apache document root (to be run as default)
COPY index.sh /usr/local/apache2/htdocs/index.sh

# Ensure the script is executable
RUN chmod +x /usr/local/apache2/htdocs/index.sh

# Configure Apache to enable CGI, headers, and expires modules
RUN echo "<Directory \"/usr/local/apache2/htdocs\">" >> /usr/local/apache2/conf/httpd.conf && \
    echo "    Options +ExecCGI" >> /usr/local/apache2/conf/httpd.conf && \
    echo "    AddHandler cgi-script .sh" >> /usr/local/apache2/conf/httpd.conf && \
    echo "    DirectoryIndex index.sh" >> /usr/local/apache2/conf/httpd.conf && \
    echo "    Require all granted" >> /usr/local/apache2/conf/httpd.conf && \
    echo "</Directory>" >> /usr/local/apache2/conf/httpd.conf && \
    echo "<IfModule mod_headers.c>" >> /usr/local/apache2/conf/httpd.conf && \
    echo "    Header set Cache-Control \"no-store, no-cache, must-revalidate, max-age=0\"" >> /usr/local/apache2/conf/httpd.conf && \
    echo "    Header set Pragma \"no-cache\"" >> /usr/local/apache2/conf/httpd.conf && \
    echo "    Header set Expires \"0\"" >> /usr/local/apache2/conf/httpd.conf && \
    echo "</IfModule>" >> /usr/local/apache2/conf/httpd.conf && \
    echo "<IfModule mod_expires.c>" >> /usr/local/apache2/conf/httpd.conf && \
    echo "    ExpiresActive On" >> /usr/local/apache2/conf/httpd.conf && \
    echo "    ExpiresDefault \"access plus 0 seconds\"" >> /usr/local/apache2/conf/httpd.conf && \
    echo "</IfModule>" >> /usr/local/apache2/conf/httpd.conf

# Pass environment variables to Apache CGI scripts
RUN echo "PassEnv USERNAME" >> /usr/local/apache2/conf/httpd.conf && \
    echo "PassEnv PASSWORD" >> /usr/local/apache2/conf/httpd.conf && \
    echo "PassEnv URL" >> /usr/local/apache2/conf/httpd.conf

# Expose port 80 for the Apache server
EXPOSE 80

# Start Apache in the foreground
CMD ["httpd", "-D", "FOREGROUND"]

