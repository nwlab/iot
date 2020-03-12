## Know the Sound Cards

```
$ more /proc/asound/cards
 0 [ALSA           ]: bcm2835 - bcm2835 ALSA
                      bcm2835 ALSA
 1 [Device         ]: USB-Audio - USB PnP Audio Device
                      USB PnP Audio Device at usb-3f980000.usb-1.4, full speed
```
```
# more /proc/asound/cards
 0 [seeed2micvoicec]: seeed-2mic-voic - seeed-2mic-voicecard
                      seeed-2mic-voicecard
#
```

## Turn up the volume

A lot of times when sound applications seem to fail, it is because we forget to
turn up the volume.

Volume adjustment can be done with `alsamixer`. This program makes use of some
function keys (`F1`, `F2`, etc). 

```
$ alsamixer
```
`F6` to select between sound cards  
`F3` to select playback volume (for speaker)  
`F4` to select capture volume (for mic)  
`⬆` `⬇` arrow keys to adjust  
`Esc` to exit

## Test the speaker

```
$ speaker-test -t wav
```

Press `Ctrl-C` when done.

## Record a WAV file

Enter this command, then speak to the mic, press `Ctrl-C` when you are
finished:

```
$ arecord -D plughw:0,0 abc.wav
```

`-D plughw:0,0` tells `arecord` where the device is. In this case, device is
the mic. It is at index 0.

`plughw:1,0` actually refers to "Sound Card index 1, Subdevice 0", because a
sound card may house many subdevices. Here, we don't care about subdevices and
always give it a `0`. The only important index is the sound card's.

## Play a WAV file

```
$ aplay -D plughw:0,0 abc.wav
```

Here, we tell `aplay` to play to `plughw:0,0`, which refers to "Sound Card index 0,
Subdevice 0", which leads to the speaker.

If you `aplay` and `arecord` successfully, that means the speaker and microphone
are working properly. We can move on to add more capabilities.

## Verify Pico, the Text-to-Speech engine

```
$ pico2wave -w abc.wav "Good morning. How are you today?"
$ aplay -D plughw:0,0 abc.wav
```

## Verify Pocketsphinx, the Speech-to-Text engine

```
$ pocketsphinx_continuous -adcdev plughw:0,0 -inmic yes
$ pocketsphinx_continuous -adcdev plughw:0,0 -hmm /usr/share/pocketsphinx/model/lm/ru/zero_ru.cd_semi_4000/ -jsgf /root/assist/speech/gr.gram -dict /root/assist/speech/ru.dic  -inmic yes
```

`pocketsphinx_continuous` interprets speech in *real-time*. It will spill out
a lot of stuff, ending with something like this:

```
Warning: Could not find Capture element
READY....
```

Now, **speak into the mic**, and note the results. At first, you may find it
funny. After a while, you realize it is horribly inaccurate.

For it to be useful, we have to make it more accurate.

## Verify RHVoice

```
echo "Система умного вигвама приветствует вас" | RHVoice-test -p Anna
```

## Verify Espeak

```
espeak "Text you wish to hear back"
espeak "Text you wish to hear back" -w test.wav
aplay test.wav
espeak  -vru "Русский синтезатор речи"
```

## Verify speech-dispatcher

```
spd-say -o rhvoice -t female1 "hello"
echo "Проверка синтезатора речи2" | spd-say -o rhvoice -l ru -e -t male1
```

## Verify snowboy
```
python3 demo.py resources/models/jarvis.umdl
```

