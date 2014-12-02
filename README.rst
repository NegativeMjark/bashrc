My bashrc
=========

Setup::

    git clone https://github.com/NegativeMjark/bashrc.git .bashrc.d
    cat >> .bashrc <<EOF
    for rc in \`ls ~/.bashrc.d | sort | grep "sh$"\`; do
        . ~/.bashrc.d/$rc
    done
    EOF

