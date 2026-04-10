#!/bin/bash

sudo sed -i '1i auth    sufficient pam_fprintd.so' /etc/pam.d/sudo
