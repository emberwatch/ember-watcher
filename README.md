# EmberWatcher

A TwitterStream Daemon picking up Tweets about `Ember.js` and `#emberjs`.

## Current Functionality

- Saves any urls directly to PostgreSQL

## Desired Functionality

- Farm persistence to a Worker via a Job Queue (Sidkiq)
- Store Tweet JSON
- Automatically post URLs/Counts directly to http://EmberWatch.com
- Perform analytics
