FROM erlang:18

RUN apt-get update && \
    apt-get install -y python perl libtemplate-perl gnuplot openssh-server && \
    echo "PubkeyAcceptedKeyTypes=+ssh-dss" >> /etc/ssh/ssh_config && \
    echo "StrictHostKeyChecking no" >> /etc/ssh/ssh_config && \
    echo "PubkeyAcceptedKeyTypes=+ssh-dss" >> /etc/ssh/sshd_config && \
    ssh-keygen -t dsa -P '' -f ~/.ssh/id_dsa && \
    cat ~/.ssh/id_dsa.pub >> ~/.ssh/authorized_keys && \
    curl http://tsung.erlang-projects.org/dist/tsung-1.7.0.tar.gz --output /tmp/tsung-1.7.0.tar.gz \
    && cd /tmp/ \
    && tar xzf ./tsung-1.7.0.tar.gz \
    && cd tsung-1.7.0 \
    && ./configure \
    && make \
    && make install \
    && rm -rf /tmp/tsung* \
    && cd /root/ \
    && touch tsung.log

EXPOSE 8091

# CMD ["/bin/bash"]
CMD /etc/init.d/ssh start && tsung -k start > /root/tsung.log 
