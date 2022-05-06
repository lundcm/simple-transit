# simple-transit

Commands:

- `~/go/bin/transitland dmfr sync -dburl postgres://postgres:LovooPheeThiu1li@localhost/transit ./*.json`
- `~/go/bin/transitland dmfr fetch -dburl postgres://postgres:LovooPheeThiu1li@localhost/transit`
- `~/go/bin/transitland dmfr import -dburl postgres://postgres:LovooPheeThiu1li@localhost/transit -activate -create-missing-shapes -deduplicate-stop-times -interpolate-stop-times -normalize-timezones -simplify-calendars -simplify-shapes 0.000005 -workers 64`
