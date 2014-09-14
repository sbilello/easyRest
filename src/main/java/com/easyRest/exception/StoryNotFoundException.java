package com.easyRest.exception;


@SuppressWarnings("serial")
public final class StoryNotFoundException extends Exception {
	public StoryNotFoundException() {
        super();
    }
    public StoryNotFoundException(String message, Throwable cause) {
        super(message, cause);
    }
    public StoryNotFoundException(String message) {
        super(message);
    }
    public StoryNotFoundException(Throwable cause) {
        super(cause);
    }
}
