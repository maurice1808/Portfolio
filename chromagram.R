library(tidyverse)
library(spotifyr)
library(compmus)

Sys.setenv(SPOTIFY_CLIENT_ID = '7750a3cc97f3426cb5373ed0ca83a5cd')
Sys.setenv(SPOTIFY_CLIENT_SECRET =  '31379173cced4bc4869a105ac9d92e0d')

vossi <- 
  get_tidy_audio_analysis('05JdgtCKkZ5CoOjM5KS4EG') %>% 
  select(segments) %>% unnest(segments) %>% 
  select(start, duration, pitches)

vossi %>% 
  mutate(pitches = map(pitches, compmus_normalise, 'chebyshev')) %>% 
  compmus_gather_chroma %>% 
  ggplot(
    aes(
      x = start + duration / 2, 
      width = duration, 
      y = pitch_class, 
      fill = value)) + 
  geom_tile() +
  labs(x = 'Time (s)', y = NULL, fill = 'Magnitude') +
  theme_minimal()


