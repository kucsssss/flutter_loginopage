package com.example.userid.api;

import com.example.userid.model.Person;
import com.example.userid.service.PersonService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.UUID;

@CrossOrigin(origins = "http://localhost:")
@RequestMapping("api/v1/person")
@RestController
public class PersonContoller {

    private final PersonService personService;

    @Autowired
    public PersonContoller(PersonService personService) {
        this.personService = personService;
    }

    @PostMapping
    public void addPerson(@RequestBody Person person) {
        personService.addPerson(person);
    }

    @GetMapping
    public List<Person> getAllPeople() {
        return personService.getAllPeople();
    }

    @GetMapping(path = "{id}")
    public Person getPersonById(@PathVariable("id") UUID id) {
        return personService.getPersonById(id)
                .orElse(null);
    }

    @DeleteMapping(path = "{id}")
    public void deletePersonById(@PathVariable("id") UUID id){
        personService.deletePerson(id);
    }

    @PutMapping
    public void updatePersonById(@PathVariable("{id}") UUID id, @RequestBody Person personToUdpate){
        personService.updatePerson(id, personToUdpate);
    }
}
