# MAIGA Monitoring System Configuration

## Alert Thresholds

### 1. Rate Limits
```ruby
RATE_LIMIT_THRESHOLDS = {
  tweets_per_hour: 300,      # Twitter limit: 300/3hrs
  mentions_per_minute: 5,    # Avoid spam detection
  follows_per_day: 400,      # Twitter limit: 400/day
  dms_per_day: 1000         # Twitter limit
}

ALERT_LEVELS = {
  warning: 75,              # Alert at 75% of limit
  critical: 90              # Critical at 90% of limit
}
```

### 2. Performance Metrics
```ruby
PERFORMANCE_THRESHOLDS = {
  response_time: 30.seconds,
  error_rate: 5.percent,
  memory_usage: 80.percent,
  cpu_usage: 70.percent
}
```

### 3. Engagement Metrics
```ruby
ENGAGEMENT_THRESHOLDS = {
  min_daily_interactions: 100,
  max_negative_sentiment: 20.percent,
  min_positive_engagement: 60.percent
}
```

## Monitoring Endpoints

### 1. Health Checks
```ruby
# System health endpoints
/health/twitter    # Twitter API status
/health/bot       # Bot system status
/health/memory    # Memory usage
/health/rate      # Rate limit status
```

### 2. Metrics Collection
```ruby
# Prometheus metrics
custom_metrics = {
  'maiga_responses_total': Counter,
  'maiga_response_time_seconds': Histogram,
  'maiga_sentiment_ratio': Gauge,
  'maiga_rate_limit_remaining': Gauge
}
```

### 3. Log Patterns
```ruby
# Critical log patterns to alert on
ALERT_PATTERNS = [
  'Rate limit exceeded',
  'API authentication failed',
  'Character response generation failed',
  'Multiple consecutive errors',
  'Inappropriate response detected'
]
```

## Alert Configurations

### 1. Immediate Alerts (PagerDuty/Slack)
- Rate limit approaching (>90%)
- API authentication issues
- System crashes
- Inappropriate response detection
- Security alerts

### 2. Daily Digest (Email)
- Performance metrics
- Engagement statistics
- Error summaries
- Rate limit usage
- Popular interactions

### 3. Weekly Reports
- Trend analysis
- System health overview
- Community growth metrics
- Content performance
- Resource utilization

## Recovery Procedures

### 1. Rate Limit Recovery
```ruby
def handle_rate_limit
  1. Pause new responses
  2. Clear queue
  3. Wait for reset
  4. Resume with reduced rate
end
```

### 2. Error Recovery
```ruby
def handle_system_error
  1. Log error details
  2. Switch to fallback mode
  3. Notify development team
  4. Implement recovery strategy
end
```

### 3. Content Issues
```ruby
def handle_content_issue
  1. Delete problematic tweet
  2. Log incident
  3. Update filter rules
  4. Review similar content
end
```

## Dashboard Configuration

### 1. Main Metrics
```ruby
dashboard_panels = {
  real_time: [
    'Active responses',
    'Queue length',
    'Rate limit status',
    'Error rate'
  ],
  hourly: [
    'Response volume',
    'Engagement rate',
    'Sentiment analysis',
    'Performance metrics'
  ],
  daily: [
    'Growth metrics',
    'Content performance',
    'Team interaction stats',
    'Community health'
  ]
}
```

### 2. Alert Views
```ruby
alert_dashboard = {
  critical: {
    rate_limits: true,
    errors: true,
    security: true
  },
  warning: {
    performance: true,
    engagement: true,
    content: true
  },
  info: {
    statistics: true,
    trends: true
  }
}
```

## Backup Systems

### 1. Data Backup
```ruby
backup_schedule = {
  response_logs: 'hourly',
  interaction_history: 'daily',
  performance_metrics: 'weekly',
  system_configuration: 'on_change'
}
```

### 2. Failover Configuration
```ruby
failover_config = {
  primary_region: 'us-east-1',
  backup_region: 'us-west-2',
  switch_threshold: {
    error_rate: 10.percent,
    latency: 5.seconds
  }
}
```

## Maintenance Windows

### 1. Regular Maintenance
```ruby
maintenance_schedule = {
  daily: '03:00 UTC', # Low traffic period
  weekly: 'Sunday 02:00 UTC',
  monthly: 'First Sunday 02:00 UTC'
}
```

### 2. Emergency Maintenance
```ruby
emergency_procedures = {
  notification_channels: ['Slack', 'Email', 'SMS'],
  max_downtime: 30.minutes,
  required_approvals: 2
}
``` 