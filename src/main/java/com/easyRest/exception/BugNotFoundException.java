package com.easyRest.exception;


@SuppressWarnings("serial")
public final class BugNotFoundException extends Exception {
	public BugNotFoundException() {
        super();
    }
    public BugNotFoundException(String message, Throwable cause) {
        super(message, cause);
    }
    public BugNotFoundException(String message) {
        super(message);
    }
    public BugNotFoundException(Throwable cause) {
        super(cause);
    }
}
