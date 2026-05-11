# Poseidon

> Master of your fridge — an iOS app that tracks food expiry and suggests recipes from what's already in your fridge.

**Repository:** https://github.com/Fzgt/Poseidon

## Features

- 📦 **Track** — add food with name, quantity, unit, and expiry date
- 🔔 **Alerts** — home dashboard shows what's expiring within 3 days
- 🍽 **Recipes** — ranked by what's about to expire, with a per-recipe "what you have" vs "still need" breakdown
- ✏️ **Edit & delete** — tap any item to edit, or swipe left to remove

## How to use

1. **Home** opens to your fridge dashboard with three stats — total items, expiring soon, fresh.
2. Tap any stat card to see the filtered list.
3. **Add food** — tap *Manual* on the home screen, fill the form, then *Add to fridge*. (Scan coming soon.)
4. **Edit / delete** — tap a food row to edit its details, or swipe left on it to delete.
5. **Find recipes** — tap *Recipe ideas → Cook with your fridge* to see recipes sorted by what's expiring soonest. Tap a recipe to see what's in your fridge vs what you still need.

## Tech stack

SwiftUI · Observation (`@Observable`) · SF Symbols · Zero third-party dependencies.
