FROM mediawiki:lts

LABEL maintainer="sysadmins@m-iti.org"

# Install php-ldap extension
RUN apt-get update && \
    apt-get install libldap2-dev -y && \
    rm -rf /var/lib/apt/lists/* && \
    docker-php-ext-configure ldap --with-libdir=lib/x86_64-linux-gnu/ && \
    docker-php-ext-install ldap

# Install mediawiki ldap extension
RUN curl -fSL https://extdist.wmflabs.org/dist/extensions/LdapAuthentication-REL1_27-b0dba33.tar.gz -o LdapAuthentication.tar.gz && \
    tar -xz -f LdapAuthentication.tar.gz && \
    mv LdapAuthentication extensions/ && \
    rm LdapAuthentication.tar.gz && \
    chown -R www-data:www-data extensions
