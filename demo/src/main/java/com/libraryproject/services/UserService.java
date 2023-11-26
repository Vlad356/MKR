package com.libraryproject.services;

import com.libraryproject.models.Book;
import com.libraryproject.models.User;
import com.libraryproject.models.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Optional;

@Service
public class UserService {
    @Autowired
    private UserRepository userRepository;

    public User get(Long id){
        Optional<User> byId = userRepository.findById(id);

        if (byId.isPresent())
        {
            return byId.get();
        }
        throw new RuntimeException("User not found");
    }

    public List<User> getAllUsers(){
        Iterator<User> iterator = userRepository.findAll().iterator();

        List<User> users = new ArrayList<>();

        while (iterator.hasNext()){
            users.add(iterator.next());
        }
        return users;
    }

    public User create(User user){
        User save = userRepository.save(user);
        return save;
    }
    public User update (Long id, User user){
        User original = get(id);
        original.setFistName(user.getFistName());
        original.setSecondName(user.getSecondName());
        original.setThirdName(user.getThirdName());
        original.setPhoneNumber(user.getPhoneNumber());
        original.setExpired(user.getExpired());

        User updated = userRepository.save(original);
        return updated;
    }
    public void delete(Long id){
        User user = get(id);
        userRepository.delete(user);
    }
}
