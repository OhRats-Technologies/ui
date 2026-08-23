package ui

import (
	"embed"
	"io/fs"
)

//go:embed css/* images/*
var assets embed.FS

// Assets returns the shared OhRats visual assets.
func Assets() fs.FS {
	return assets
}
