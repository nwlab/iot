#!/bin/bash
pocketsphinx_continuous -adcdev plughw:1,0 -hmm /root/zero_ru_cont_8k_v3/zero_ru.cd_semi_4000/ -jsgf /root/rus_pi.gram -dict /root/rus_pi_dict  -inmic yes -logfn /dev/null