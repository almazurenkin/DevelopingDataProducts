### User Instruction

In order to use the application please specify search parameters in the
left-side **"Choose Parameters"** panel (each parameter offer selection options
in the drop-down menu):

- Marital Status
- Race
- Education
- Job Class
- Health State
- Health Insurance

Age can be changed using a slide bar.

Changes in parameters or Age selection are immediately reflected in the
**Wage Prediction** tab on the right side of the page. It shows selected age,
*recommended salary* for the set of selected parameters and age, and chart of
*predicted wages per age*.

**!** Please note when the server is re-started prediction model needs to be generated,
hence there might be a delay before the application is ready for use.

**Data** tab shows data used for building prediction model of the application.

**Documentation** tab is the one you are on.

### Application Details and Data Source

Application uses statistical prediction model built using
Generalized Boosted Regression Models method from the Wage data set from the ISLR R package.

GitHub repo: https://github.com/almazurenkin/DevelopingDataProducts.

Data was manually assembled by Steve Miller, of Open BI (www.openbi.com),
from the March 2011 Supplement to Current Population Survey data.

http://thedataweb.rm.census.gov/TheDataWeb

### Disclaimer

This application is a part of Developing Data Products @ Coursera course project,
created for education purpose only and **should not be used for any real-life situation
such as job application, interview, salary negotiations, or similar**.
