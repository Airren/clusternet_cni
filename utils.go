package main

import (
	"io"
	"os"
	"os/exec"
)

func Exec(cmdStr string, out io.Writer, args ...string) error {
	cmd := exec.Command(cmdStr, args...)
	cmd.Stdout = out
	cmd.Stderr = os.Stderr
	err := cmd.Run()
	return err
}
