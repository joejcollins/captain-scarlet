"""Demo of a test."""

import src_python.package.shit as shit

def test_shit() -> None:
    """Confirm the string is returned."""
    # Arrange

    # Act
    returned_string = shit.shit()
    # Assert
    returned_string == "shit"
