# GitLab Recurring Issues

A Docker image for creating recurring issues based on templates as part of a GitLab scheduled pipeline.

## Usage

Create template issues in the `.gitlab/recurring_issue_templates/` directory. Template issues use YAML front matter for configuration settings. The template body is used as the issue description.

```markdown
---
title: "Daily reminder" # The issue title
confidential: false
duein: "24h" # Duration string as per https://pkg.go.dev/time?tab=doc#ParseDuration (e.g "30m", "1h")
crontab: "@daily" # The recurrance schedule using crontab syntax, such as "*/30 * * * *", or a predefined value of @annually, @yearly, @monthly, @weekly, or @daily
---
This is your daily reminder to perform the following actions

* [ ] Action 1
* [ ] Action 2
```

Create a pipeline in the `.gitlab-ci.yml` file:

```yaml
recurring issues:
  image: ph1ll/gitlab-recurring-issues
  script: gitlab-recurring-issues
  only: 
    - schedules
```

Create project CI/CD variables:

| Name | Value |
| ---- | ----- |
| GITLAB_API_TOKEN | The API access token for the user account that will create the issues (see: https://docs.gitlab.com/ce/user/profile/personal_access_tokens.html) | 

Finally, create a new schedule under the project CI/CD options, ensuring that the pipeline runs at least as often as your most frequent job.