# Proxy Chain Kit

这是一个给已经有 iKuuu、Clash 等基础代理，同时希望让 Claude Code 单独使用 Webshare 固定住宅 IP 的 macOS 用户准备的一键分流工具。

普通上网继续走原来的基础代理，只有 Claude Code 走 Webshare，不会让浏览器、ChatGPT、视频和下载消耗住宅代理流量。

## 安装方式一：直接交给 Agent

把下面这段提示词完整复制给 Codex、Claude Code，或者其他能够操作终端的 Agent：

```text
请帮我在 macOS 上安装并配置 Proxy Chain Kit。

项目地址：https://github.com/rosehahah/proxy-chain-kit

我的目标是：普通上网继续走现有的 iKuuu、Clash 或其他基础代理；只有 Claude Code 通过“基础代理 → Webshare 固定住宅代理”访问网络。

请按下面要求执行：
1. 先检查当前基础代理是否正常，并确认它的本地地址和端口；不要关闭或替换我现有的基础代理。
2. 克隆并阅读项目，运行安装程序。检查电脑上是否已有 Mihomo 或 Clash Verge Rev，没有时再告诉我如何安装。
3. 配置前备份 ~/.claude/settings.json。先在独立本地端口测试代理链，测试成功后再让 Claude Code 使用它。
4. Webshare 的 Proxy Address、Port、Username 和 Password 如果已经保存在我的本机文件中，可以读取后配置，但绝对不要在聊天、日志、截图或 Git 提交中回显；如果找不到，就停下来让我在终端里自己输入。
5. 普通流量和 ChatGPT 不能走 Webshare。不要打开或启动 Claude Code，只完成网络配置和测试。
6. 完成后运行 proxy-chain test，告诉我基础代理出口、住宅代理出口、住宅 IP 所在城市，以及后台服务是否正常。汇报时不要显示用户名、密码或订阅地址。
7. 如果测试失败，不要破坏当前网络；保留备份并说明失败原因。
```

Agent 完成后，只需要确认测试结果。整个过程中不要把 Webshare 密码直接发到公开聊天或 Issue。

## 安装方式二：自己操作

### 第一步：准备好两样东西

1. 打开 iKuuu、Clash 或其他基础代理，确认本地代理端口可用，通常是 `127.0.0.1:7890`。
2. 在 Webshare 后台找到一个固定住宅代理，准备好 `Proxy Address`、`Port`、`Username` 和 `Password`。

电脑还需要安装 Mihomo。已经安装 Clash Verge Rev 的用户通常不需要额外处理；也可以使用 Homebrew：

```bash
brew install mihomo
```

### 第二步：安装并填写代理信息

```bash
git clone https://github.com/rosehahah/proxy-chain-kit.git
cd proxy-chain-kit
./install.sh
~/.local/bin/proxy-chain init
```

按照终端提示填写基础代理和 Webshare 信息。密码会保存到 macOS 钥匙串，不会写进项目仓库。

### 第三步：检查后直接使用 Claude Code

```bash
~/.local/bin/proxy-chain test
```

看到“基础代理出口”和“Claude Code 出口”是两个不同 IP，并显示“双层代理工作正常”，就可以像平时一样启动 Claude Code：

```bash
claude
```

以后使用 Claude Code 时，保持基础代理处于连接状态即可。

常用命令：

```bash
~/.local/bin/proxy-chain status
~/.local/bin/proxy-chain test
~/.local/bin/proxy-chain uninstall
```

> 这个工具只负责代理链路和流量分流，不提供代理账号，也不能保证任何平台账号不受限制。请遵守代理服务商、目标服务和所在地区的规则。

## 如果帮到了你，欢迎给个 Star ⭐

一个 Star 能让更多正在折腾 Claude Code 网络环境的人看到这个项目，也会鼓励我继续维护。

## 来认识我

我是小苋，来自「小苋 AI 圈」。我会持续分享 AI 工具、Claude Code、自动化工作流和真实实践，欢迎扫码来认识我。

<p align="center">
  <img src="assets/xiaoxian-ai-circle-wecom.png" width="320" alt="小苋 AI 圈企业微信二维码">
</p>

## License

[MIT](LICENSE)
