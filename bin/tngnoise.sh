#!/bin/bash -e

play -c 2 -n -c1 synth whitenoise lowpass -1 120 lowpass -1 120 lowpass -1 120 gain +10
