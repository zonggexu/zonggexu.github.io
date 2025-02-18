---
author: lee.so
title: Math Typesetting
date: 2019-03-08
description: A brief guide to setup KaTeX
math: true
---

Mathematical notation in a Hugo project can be enabled by using third party JavaScript libraries.

<!--more-->

In this example we will be using [KaTeX](https://katex.org/)

- Create a partial under `/layouts/partials/math.html`
- Within this partial reference the [Auto-render Extension](https://katex.org/docs/autorender.html) or host these scripts locally.
- Include the partial in your templates like so:

```bash
{{ if or .Params.math .Site.Params.math }}
{{ partial "math.html" . }}
{{ end }}
```

- To enable KaTeX globally set the parameter `math` to `true` in a project's configuration
- To enable KaTeX on a per page basis include the parameter `math: true` in content files

**Note:** Use the online reference of [Supported TeX Functions](https://katex.org/docs/supported.html)

{{< math.inline >}}

{{</ math.inline >}}

### Examples

{{< math.inline >}}

<p>
Inline math: \(\varphi = \dfrac{1+\sqrt5}{2}= 1.6180339887…\)
</p>

{{</ math.inline >}}

Block math:

$$
 \varphi = 1+\frac{1} {1+\frac{1} {1+\frac{1} {1+\cdots} } }
$$


### 一段思考

```bash
func (missAppHomeApi *MissAppHomeApi) CreateMissAppHome(c *gin.Context) {
	var homeInDTO homeReq.AddHomeInDTO
	err := c.ShouldBind(&homeInDTO)
	if err != nil {
		response.ErrorMessage(err.Error(), c)
		return
	}

	tokenStr := c.Request.Header.Get("Authorization") //这里是个关键点，刷新token时也要带上token

	claims, err1 := middleware.ParseAppToken(tokenStr)

	userA, err2 := UserService.GetAppUserWithUUID(claims.Uid)
	if err1 != nil || err2 != nil {
		global.GVA_LOG.Error("创建失败!", zap.Error(err1))
		response.ErrorMessage("用户不存在!", c)
		return
	}
	
	if userA.HomeId.lenth > 0 {
		// 获取A home 返回
	}

	userB, err2 := UserService.GetAppUserWithAuthCode(homeInDTO.PairingCode)
	if err2 != nil {
		global.GVA_LOG.Error("配对码不正确创建家庭失败!", zap.Error(err2))
		response.ErrorMessage("配对码不正确", c)
		return
	}
	
	if userB.HomeId.lenth > 0 {
		global.GVA_LOG.Error("当前用户已有家庭!", zap.Error(err2))
		response.ErrorMessage("当前用户已有家庭", c)
		return
	}

	newHome := missAppHome.MissAppHome{UserPhoneA: userA.UserName, UserPhoneB: userB.UserName, HomeName: homeInDTO.HomeName, HomeScore: 0, UserA: userA, UserB: userB, TogetherDate: homeInDTO.TogetherDate}

	err3 := HomeService.CreateMissAppHome(&newHome)
	if err3 != nil {
		response.ErrorMessage("创建家庭失败", c)
		return
	}

	c.JSON(200, newHome)

}
```
