if [ -f /opt/{{ openfoam_package }}/etc/bashrc ]; then
  . /opt/{{ openfoam_package }}/etc/bashrc
fi

if [ -f /opt/ofvm/ofvm.bash ]; then
  . /opt/ofvm/ofvm.bash
fi

# Otherwise the X11 forwarding for paraFoam will NOT work.
export QT_X11_NO_MITSHM=1
