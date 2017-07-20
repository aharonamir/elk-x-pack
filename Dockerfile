FROM sebp/elk
MAINTAINER Amir Aharon <aharon.amir@gmail.com>

ENV ES_JAVA_OPTS="-Des.path.conf=/etc/elasticsearch"

RUN /usr/share/elasticsearch/bin/elasticsearch-plugin install --batch x-pack
RUN /opt/kibana/bin/kibana-plugin install x-pack

USER root
RUN 	\
	echo "xpack.security.enabled: false"	>> /usr/share/kibana/config/kibana.yml && \
	echo "xpack.graph.enabled: false" 	>> /usr/share/kibana/config/kibana.yml && \
	echo "xpack.watcher.enabled: false"	>> /usr/share/kibana/config/kibana.yml && \
	echo "xpack.reporting.enabled: false" 	>> /usr/share/kibana/config/kibana.yml && \
	chown -R kibana:kibana /usr/share/kibana
USER kibana
#https://github.com/elastic/kibana/issues/6057
RUN kibana  2>&1 | grep -m 1 "Optimization of .* complete in .* seconds" 
