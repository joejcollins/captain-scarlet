"""Create Logbook Files

Create a series of MarkDown files for a weekly log book.  Each file
should be:

* Named after the week number in that year.
* Have a # Title at the top duplicating the week number in that year.
* Should contain the 5 working days in the month with a ## Title.
"""
# pylint: disable=locally-disabled, line-too-long
import calendar
import datetime
import unittest

# Year to generate logbook files for.  This should really be an
# argument but who can be bothered.
YEAR = 2023

# An instance of the calendar is required for itermonthdates().  This
# interator shows the days in the week before the beginning and after
# the end of the month, hence the instance needs to know the start
# day of the month, 0 is Monday.
MY_CALENDAR = calendar.Calendar(0)  # Start of week is 0


class Week:  # pylint: disable=too-few-public-methods
    """ A week object

    Should return the days for any given week between 1 and 52.
     """
    week_number = 1
    year = 2023

    def __init__(self, week_number, year):
        # TODO: Week_number should be an integer between 1 and 52
        self.week_number = week_number
        self.year = year
        self.year_date_start = datetime.date(year, 1, 1)
        self.year_date_end = datetime.date(year, 12, 31)

    def dates(self):
        """ Return an array of the dates for the week of interest

        So this should provide 7 days starting on Monday.  Unless
        it is the beginning or end of the year in which case it 
        might be fewer days.
        """
        first_day_of_week = self._get_first_day_of_week(self.week_number, self.year)
        date = first_day_of_week
        dates = []
        for i in range(1, 7):
            dates.append(date)
            date += datetime.timedelta(days=1)
            # Only do the working week, so stop at Saturday
            if date.weekday() == calendar.SATURDAY:
                break
        return dates

    def _get_first_day_of_week(self, week_number, year):
        """ Get the first Monday of the week for the week number given 

        By incrementing through the weeks until you get to the one you
        are interested in.
        """
        # The first day of the first week is the beginning of the year
        first_day_of_week = self.year_date_start
        # Count up the weeks (or not if you are on the first week of the year)
        if week_number > 1:  # get the second week of the year
            first_day_of_week = self._increment_to_next_monday(first_day_of_week)
        if week_number > 2:  # increment to the first Monday (in weeks)
            first_day_of_week = first_day_of_week + datetime.timedelta(weeks=week_number - 2)
        return first_day_of_week

    def _increment_to_next_monday(self, date):
        """ Increment the date until you get to the next Monday

        Used for counting through the weeks in the year, until
        you get to the week you are interested in.
        """
        for i in range(7):
            date += datetime.timedelta(days=1)
            if date.weekday() == calendar.MONDAY:
                break
        return date


class TestWeek(unittest.TestCase):
    """ Tests for the week

    VSCode doesn't show the output in a hover window the way it does for
    pytest, so to see the errors use 
    `python -m unittest discover -s Log -p "*_test.py"` or use debug. """

    def test_class_is_present(self):
        """ Confirm that the class is present """
        try:
            Week(1, 2020)
        except NameError:
            self.fail("Class not present")

    def test_method_is_present(self):
        """ Confirm that the method is present """
        test_week = Week(1, 2020)
        try:
            test_week.dates()
        except AttributeError:
            self.fail("Method not present")

    def test_increment_to_next_monday(self):
        """ Confirm the first Monday for 3 different weeks in 2020 """
        test_week = Week(1, 2020)
        # First day of the year is Wednesday 1 January, should increment to Monday 6 January
        first_day_of_year = datetime.date(2020, 1, 1)
        first_monday_of_year = datetime.date(2020, 1, 6)
        self.assertEqual(test_week._increment_to_next_monday(first_day_of_year), first_monday_of_year)
        # One Monday should increment to the next Monday
        one_monday = datetime.date(2020, 2, 17)
        next_monday = datetime.date(2020, 2, 24)
        self.assertEqual(test_week._increment_to_next_monday(one_monday), next_monday)
        # Last Monday of the year should increment into next year
        last_monday_of_year = datetime.date(2020, 12, 28)
        next_monday_of_next_year = datetime.date(2021, 1, 4)
        self.assertEqual(test_week._increment_to_next_monday(last_monday_of_year), next_monday_of_next_year)

    def test_get_first_day_of_week(self):
        """ Make sure the first day of the week should be a Monday unless 
        it is the first week of the year 

        * 2020 started on a Wednesday
        * 2020 my birthday was on a Monday
        * 2018 started on a Monday
        """
        test_week = Week(1, 2020)
        first_day_of_the_week = test_week.dates()[0]
        week_day = first_day_of_the_week.weekday()
        self.assertEqual(week_day, calendar.WEDNESDAY)
        test_week = Week(2, 2020)
        first_day_of_the_week = test_week.dates()[0]
        self.assertEqual(first_day_of_the_week.day, 6)
        week_day = first_day_of_the_week.weekday()
        self.assertEqual(week_day, calendar.MONDAY)
        test_week = Week(1, 2018)
        first_day_of_the_week = test_week.dates()[0]
        self.assertEqual(first_day_of_the_week.day, 1)
        week_day = first_day_of_the_week.weekday()
        self.assertEqual(week_day, calendar.MONDAY)

    def test_days_in_first_week(self):
        """ Confirm first week has 5 days and starts on Wednesday """
        test_week = Week(1, 2020)
        self.assertEqual(len(test_week.dates()), 5)

    def test_the_fourth_week(self):
        """ Confirm that the fourth week of 2020 starts on 20 Jan """
        test_week = Week(4, 2020)
        first_day_of_the_week = test_week.dates()[0]
        self.assertEqual(first_day_of_the_week.day, 20)


if __name__ == "__main__":
    for week in range(1, 54):
        # The zfill puts zeros in front of the week number so that
        # the file names order nicely in the file explorer
        file_name = "Week" + "-" + str(week).zfill(2) + ".md"
        print(file_name)
        file_obj = open(file_name, "w")
        file_obj.write("# Week " + str(week) + "\n\n")
        current_week = Week(week, YEAR)
        current_week_days = current_week.dates()
        for day in current_week_days:
            file_obj.write("## " + day.strftime("%A %d %B %Y") + "\n\n")
        file_obj.close()
