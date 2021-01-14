# dotfiles

## Notes

### OpenJDK & Papyrus

This issue arose when trying to launch Papyrus on OpenJDK:

> code signature in
(/usr/local/Cellar/openjdk/15.0.1/libexec/openjdk.jdk/Contents/MacOS/libjli.dylib) not valid for
use in process using Library Validation: mapped file has no cdhash, completely unsigned? Code
has to be at least ad-hoc signed.

A brute force solution is to disable security assessment completely with `sudo spctl --master-disable`.
