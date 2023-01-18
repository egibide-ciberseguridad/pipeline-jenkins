FROM nginx

COPY www/ /usr/share/nginx/html/

RUN sed -i "s/{{ FECHA }}/$(date)/g" /usr/share/nginx/html/index.html
