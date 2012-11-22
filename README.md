# FlexAlertQueue

This is a small package to allow you to render multiple `Alert` messages without newer ones overlapping previous ones.

## Installation

Just clone this repo into your Flex Project *src* directory:

 - `cd path/2/flex/project/src`
 - `git clone git@github.com:jisaacks/FlexAlertQueue.git`

## Usage

    import FlexAlertQueue.AlertQueue;
    AlertQueue.push("It's that easy!");

## Why use it?

Normally when you have multiple `Alert.show` calls in Flex, each succeeding call will overlap the last. If you alert **"A"** then alert **"B"** the user will see the ***B*** alert first, with a modal overlay that is twice as opaque as normal because the ***A*** alert is sitting underneath it.

AlertQueue puts them in a queue and does not call succeeding Alerts until the ones before it on the queue are closed. AlertQueue uses an `Alert.show` call internally and **AlertQueue.push** has the same method siqnature as **Alert.show** so you can use it just like you would a regular alert. This just makes them behave more similar to alerts in Javascript.

Obviously its never a good idea to be bombarding your users with alerts, but if different parts of your application can send alerts, this is a good way to ensure they are always displayed in the order they are called and prevents the ugly opaque background when multiple alerts are stacked.