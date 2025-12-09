#!/bin/bash
export LD_LIBRARY_PATH=''
openscad -o $1.stl $1.scad $2 $3 $4 $5 $6
