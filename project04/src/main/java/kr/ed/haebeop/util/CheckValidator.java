package kr.ed.haebeop.util;

import kr.ed.haebeop.domain.Member;
import org.springframework.validation.Errors;
import org.springframework.validation.Validator;

import java.util.regex.Pattern;

public class CheckValidator implements Validator {

    @Override
    public void validate(Object target, Errors errors) {

        Member member = (Member)target;

        Pattern pat1 = Pattern.compile("^[a-z0-9]{5,12}", Pattern.CASE_INSENSITIVE);
        Pattern pat2 = Pattern.compile("^[a-zA-Z0-9]{8,12}", Pattern.CASE_INSENSITIVE);

        if(!(pat1.matcher(member.getId()).matches())){
            errors.rejectValue("id", "member.id.invalid", "아이디 형식이 일치하지 않습니다.");
        }
        if(!(pat2.matcher(member.getPw()).matches())){
            errors.rejectValue("pw", "member.pw.invalid", "비밀번호 형식이 올바르지 않습니다.");
        }

        String id = member.getId();
        String pw = member.getPw();

        if(id == null || id.trim().isEmpty()) {
            errors.rejectValue("id", "not value", "아이디를 입력해주세요.");
        }

        if(pw == null || pw.trim().isEmpty()) {
            errors.rejectValue("pw", "not value", "비밀번호를 입력해주세요.");
        }

    }

    @Override
    public boolean supports(Class<?> clazz) {
        return Member.class.isAssignableFrom(clazz);
    }

}