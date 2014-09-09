### rebar_assets

---

Plugin for [Rebar](https://github.com/rebar/rebar) to compile static assets.

---

### Instruction

Sample rebar.config:

```erlang
{deps, [
  {rebar_assets, ".*", {git, "git://github.com/artemeff/rebar_assets.git", "HEAD"}}
]}.

{plugins, [rebar_assets]}.

{static, [
  {files, ["application.js", "application.css"]},
  {assets_port, 3005}
]}.
```

```bash
# to compile assets
$ rebar assets
# to start server
$ rebar assets-watch
```

---

### Documentation

Soon

---

### Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
