package com.strobecorp.kirk;

import java.text.MessageFormat;
import java.util.Date;
import java.util.logging.*;

public class LogFormatter extends Formatter {

  private final static String format = "{0,date} {0,time}";
  private final static String sep    = " - ";

  public String format(LogRecord record) {
    StringBuilder sb = new StringBuilder();
    Date eventDate   = new Date(record.getMillis());
    MessageFormat f  = new MessageFormat(format);

    sb.append(f.format(format, eventDate));

    sb.append(sep);

    sb.append(record.getLevel().getLocalizedName());
    sb.append(sep);

    sb.append(formatMessage(record));

    sb.append("\n");

    return sb.toString();
  }

}
