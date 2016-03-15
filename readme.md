# Now

[Planning Doc](https://docs.google.com/document/d/1SgZb-XDTu56LKCrfVc7GSuxR8ARrnhUXqPm0d6U_YtM/edit#)


## Data Structure

- tasks
  - name: string
  - category: category_id
  - track_time_seconds: int
  - completed: bool

- categories
  - name: string
  - color: color?

- task log
  - task id: int
  - start time: datetime
  - stop time: datetime

- preferences
  - tasks limit: int = 5
  - default category: category_id = feature
  - task track times: [float] = [5, 10, 15, 20, 30, 45, 60]
  - task track default time: int = 15


### Categories
- feature
- bug
- chore
- other


### Distractions

Distractions are tasks with the default category of "distraction"

- facebook
- email
- editorial team
- marketing team
- outage
